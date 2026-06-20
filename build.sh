#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${BUILD_DIR:-${ROOT_DIR}/build}"
INSTALL_DIR="${INSTALL_DIR:-${BUILD_DIR}/install}"
BUILD_TYPE="${BUILD_TYPE:-Release}"
GENERATOR="${GENERATOR:-Ninja}"
PROJECTS="${PROJECTS:-clang;lld;mlir}"
RUNTIMES="${RUNTIMES:-}"
LLVM_TARGETS="${LLVM_TARGETS:-X86;NVPTX;AMDGPU}"
TARGETS="${TARGETS:-all}"
CHECK_TARGETS="${CHECK_TARGETS:-check-llvm check-clang check-mlir}"
CPU_COUNT="$(nproc)"
DEFAULT_JOBS="$(( CPU_COUNT > 2 ? CPU_COUNT - 2 : 1 ))"
DEFAULT_LINK_JOBS=2
JOBS="${JOBS:-${DEFAULT_JOBS}}"
LINK_JOBS="${LINK_JOBS:-${DEFAULT_LINK_JOBS}}"
ASSERTIONS="${ASSERTIONS:-ON}"
CCACHE="${CCACHE:-auto}"
USE_LLD="${USE_LLD:-auto}"

usage() {
  cat <<EOF
Usage: $(basename "$0") [install|build|test|clean]

Commands:
  install    Configure, build, and install to BUILD_DIR/install (default)
  build      Configure and build without installing
  test       Configure, build, and run LLVM/Clang/MLIR checks
  clean      Remove the build directory

Environment variables:
  BUILD_DIR    Build directory (default: ${ROOT_DIR}/build)
  INSTALL_DIR  Install prefix (default: ${BUILD_DIR}/install)
  BUILD_TYPE   CMake build type (default: Release)
  GENERATOR    CMake generator (default: Ninja)
  PROJECTS     LLVM_ENABLE_PROJECTS value
               Default: clang;lld;mlir
               Example: PROJECTS="clang;lld;mlir;openmp;offload"
  RUNTIMES     LLVM_ENABLE_RUNTIMES value (default: empty)
               Example: RUNTIMES="libcxx;libcxxabi;compiler-rt"
  LLVM_TARGETS LLVM_TARGETS_TO_BUILD value
               Default: X86;NVPTX;AMDGPU
  TARGETS      Build targets (default: all)
               Example: TARGETS="clang lld"
  CHECK_TARGETS
               Test targets (default: check-llvm check-clang check-mlir)
  JOBS         Parallel build jobs (default: nproc - 2, now ${DEFAULT_JOBS}; nproc is ${CPU_COUNT})
  LINK_JOBS    Parallel link jobs (default: ${DEFAULT_LINK_JOBS})
  ASSERTIONS   LLVM_ENABLE_ASSERTIONS value (default: ON)
  CCACHE       ON, OFF, or auto (default: auto)
  USE_LLD      ON, OFF, or auto (default: auto)
EOF
}

need_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "error: required command '$1' was not found in PATH" >&2
    exit 1
  fi
}

configure() {
  need_command cmake
  if [[ "${GENERATOR}" == "Ninja" ]]; then
    need_command ninja
  fi

  cmake_args=(
    -S "${ROOT_DIR}/llvm"
    -B "${BUILD_DIR}"
    -G "${GENERATOR}"
    -DCMAKE_BUILD_TYPE="${BUILD_TYPE}"
    -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}"
    -DLLVM_ENABLE_PROJECTS="${PROJECTS}"
    -DLLVM_TARGETS_TO_BUILD="${LLVM_TARGETS}"
    -DLLVM_ENABLE_ASSERTIONS="${ASSERTIONS}"
    -DLLVM_ENABLE_RTTI=ON
    -DLLVM_ENABLE_EH=ON
    -DLLVM_ENABLE_ZLIB=ON
    -DLLVM_ENABLE_ZSTD=ON
    -DLLVM_BUILD_LLVM_DYLIB=ON
    -DLLVM_LINK_LLVM_DYLIB=ON
    -DLLVM_OPTIMIZED_TABLEGEN=ON
    -DLLVM_BUILD_EXAMPLES=OFF
    -DLLVM_INCLUDE_EXAMPLES=OFF
    -DLLVM_INCLUDE_TESTS=ON
    -DLLVM_INCLUDE_BENCHMARKS=OFF
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  )

  if [[ -n "${RUNTIMES}" ]]; then
    cmake_args+=(-DLLVM_ENABLE_RUNTIMES="${RUNTIMES}")
  fi

  if [[ -n "${LINK_JOBS}" ]]; then
    cmake_args+=(-DLLVM_PARALLEL_LINK_JOBS="${LINK_JOBS}")
  fi

  if [[ "${CCACHE}" == "ON" ]] || { [[ "${CCACHE}" == "auto" ]] && command -v ccache >/dev/null 2>&1; }; then
    cmake_args+=(-DLLVM_CCACHE_BUILD=ON)
  fi

  if [[ "${USE_LLD}" == "ON" ]] || { [[ "${USE_LLD}" == "auto" ]] && command -v ld.lld >/dev/null 2>&1; }; then
    cmake_args+=(-DLLVM_USE_LINKER=lld)
  fi

  cmake "${cmake_args[@]}"
  ln -sf "${BUILD_DIR}/compile_commands.json" "${ROOT_DIR}/compile_commands.json"
}

build() {
  need_command cmake
  read -r -a build_targets <<< "${TARGETS}"
  cmake --build "${BUILD_DIR}" --target "${build_targets[@]}" --parallel "${JOBS}"
}

install() {
  need_command cmake
  cmake --build "${BUILD_DIR}" --target install --parallel "${JOBS}"
}

run_tests() {
  need_command cmake
  read -r -a check_targets <<< "${CHECK_TARGETS}"
  cmake --build "${BUILD_DIR}" --target "${check_targets[@]}" --parallel "${JOBS}"
}

command="${1:-install}"

case "${command}" in
  build)
    configure
    build
    ;;
  configure)
    configure
    ;;
  install)
    configure
    install
    ;;
  test|check)
    configure
    run_tests
    ;;
  clean)
    rm -rf "${BUILD_DIR}"
    ;;
  all)
    configure
    build
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    echo "error: unknown command '${command}'" >&2
    usage >&2
    exit 1
    ;;
esac
