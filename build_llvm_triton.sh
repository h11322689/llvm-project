#!/bin/bash

build_llvm() {
    start_time=$(date +%s)  # Record start time

    if [ -e build_llvm ]; then
        echo "$pwd/build_llvm exists"
    else
        mkdir build_llvm
    fi

    cmake ../ -S llvm -B build_llvm -G Ninja    \
        -DLLVM_PARALLEL_COMPILE_JOBS=6          \
        -DLLVM_PARALLEL_LINK_JOBS=4             \
        -DCMAKE_INSTALL_PREFIX="/home/lihao/work/llvm-project/install_Release"                                             \
        -DCMAKE_BUILD_TYPE=Release               \
        -DLLVM_ENABLE_PROJECTS=mlir             \
	    -DLLVM_ENABLE_ASSERTIONS=ON             \
        -DLLVM_BUILD_EXAMPLES=ON                \
        -DLLVM_BUILD_TESTS=ON                   \
        -DLLVM_BUILD_BENCHMARKS=ON              \
        -DLLVM_CCACHE_BUILD=ON                  \
        -DLLVM_INSTALL_UTILS=ON                 \
 	    #-DLLVM_USE_LINKER=lld                   \
	    -DLLVM_TARGETS_TO_BUILD="X86;NVPTX;RISCV;AMDGPU"    \
		-DMLIR_ENABLE_CUDA_RUNNER=ON            \
		#-DCMAKE_C_COMPILER=clang                \
		#-DCMAKE_CXX_COMPILER=clang++            \
		-DLLVM_ENABLE_RTTI=ON                   \
		-DMLIR_INCLUDE_INTEGRATION_TESTS=ON                     

        
        
    cd build_llvm 
    ninja install -j4

    end_time=$(date +%s)                            # Record end time
    duration=$((end_time - start_time))             # Calculate duration in seconds

    echo "Build duration: $duration seconds"        # Print compilation duration
}

build_llvm

# -S llvm                源代码目录
# -B build_llvm          构建目录
# -G Ninja               生成器类型

# -DLLVM_ENABLE_RUNTIMES  一起构建的运行时库
# -DLLVM_INSTALL_PREFIX   指定安装目录   
# -DLLVM_BUILD_TYPE       指定构件类型: DEBUG,会把debug符号表编译到最终的二进制文件里面
#                                       RELEASE：对二进制进行优化，为了生产环境的高速/高效率逻辑执行
#                                       RELWITHDEBINFO：进行release编译的同时，保留debug符号表
#                                       MINSIZEREL：优化二进制文件大小
# -DLLVM_BUILD_EXAMPLES   是否构建LLVM的示例程序
# -DLLVM_INSTALL_UTILS    是否同时安装LLVM的一些实用工具
# -DLLVM_INCLUDE_TESTS   
# -DLLVM_BUILD_TESTS      是否构建测试用例
# -DLLVM_BUILD_BENCHMARKS 是否构建性能测试
# -DLLVM_ENABLE_THREADS   如果系统库里支持了多线程（比如pthread）LLVM会自动引入多线程支持。
#                         这种情况下，LLVM会默认编译器已经支持了TLS（thread-local storage）
#			  如果你不想要或者编译器不支持的话，请关闭：-DLLVM_ENABLE_THREADS=OFF
# -DLLVM_OPTIMIZED_TABLEGEN   通常，tablegen 工具的构建选项与 LLVM 的其他部分相同。 
#                             同时，tablegen 用于生成代码生成器的大部分内容。 
#			      因此，在调试编译时，tablegen 的速度会慢很多，编译时间也会明显增加。 
#			      如果将此选项设置为 ON，则即使在调试编译时，也会开启 tablegen 的优化功能，从而缩短编译时间。 
#			      默认值为 OFF。 要打开它，需要指定 -DLLVM_OPTIMIZED_TABLEGEN=ON

# -DLLVM_USE_SPLIT_DWARF      如果编译器是 gcc 或 clang，则打开该选项将指示编译器在一个单独的文件中生成 DWARF 调试信息。
#                              对象文件的大小减小后，调试编译的链接时间将大大缩短。
#			      默认为关闭。要打开该选项，需要指定 -LLVM_USE_SPLIT_DWARF=ON

# -DLLVM_ENABLE_PROJECTS  同时构建的LLVM子项目
# -DCLANG_BUILD_EXAMPLES  是否构建clang的示例代码
# -DCLANG_INCLUDE_TESTS   是否构建clang时包含测试代码
# -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD    除了官方目标之外，LLVM 源代码树还包含实验目标
#                                         这些目标正在开发中，通常还不支持后端的全部功能
#					  当前的实验目标包括 ARC、CSKY、DirectX、M68k、SPIRV 和 Xtensa
#					  要编译 M68k 目标，需要指定 -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=M68k

