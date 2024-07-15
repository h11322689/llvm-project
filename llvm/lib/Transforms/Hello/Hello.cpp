//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Statistic.h"
// 写pass，在函数Function上操作，且需要打印数据
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "hello"

STATISTIC(HelloCounter, "Counts number of functions greeted");

namespace {
    // Hello - The first implementation, without getAnalysisUsage.
    struct Hello : public FunctionPass {
        static char ID; // Pass identification, replacement for typeid
        //构造函数
        Hello() : FunctionPass(ID) {}

        //重写父类的‘runOnFunction’函数
        bool runOnFunction(Function &F) override 
        {
            ++HelloCounter;
            errs() << "Hello: ";
            errs().write_escaped(F.getName()) << '\n';
            return false;
        }
   };
}

//初始化pass的ID
char Hello::ID = 0;
//注册Hello类，给一个命令行参数”hello”和一个名字”Hello World Pass”
static RegisterPass<Hello> X("hello", "Hello World Pass");

namespace {
  // Hello2 - The second implementation with getAnalysisUsage implemented.
    struct Hello2 : public FunctionPass {
        static char ID; // Pass identification, replacement for typeid
        Hello2() : FunctionPass(ID) {}

        bool runOnFunction(Function &F) override 
        {
            ++HelloCounter;
            errs() << "Hello: ";
            errs().write_escaped(F.getName()) << '\n';
            return false;
        }

        // We don't modify the program, so we preserve all analyses.
        void getAnalysisUsage(AnalysisUsage &AU) const override {
            AU.setPreservesAll();
        }
    };
}

char Hello2::ID = 0;
static RegisterPass<Hello2>
Y("hello2", "Hello World Pass (with getAnalysisUsage implemented)");
