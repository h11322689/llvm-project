/*************************************************************************
	> File Name: MyRISCVTargetInfo.h
	> Author: LJM
	> Mail: ljm@ljm.com 
	> Created Time: 2024年08月13日 星期二 11时40分53秒
 ************************************************************************/

#ifndef LLVM_LIB_TARGET_MYRISCV_TARGETINFO_MYRISCVTARGETINFO_H
#define LLVM_LIB_TARGET_MYRISCV_TARGETINFO_MYRISCVTARGETINFO_H

namespace llvm {

class Target;

Target &getMyRISCV32Target();

} // end namespace llvm

#endif // LLVM_LIB_TARGET_MYRISCV_TARGETINFO_MYRISCVTARGETINFO_H


