#!/bin/bash

#git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b brillo-m9-release
#git clone https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86 -b android11-mainline-release clang_tool

export PATH="/workspaces/kernel_vivo_mt6765/clang-aosp/bin:/workspaces/kernel_vivo_mt6765/gcc-64/bin:/workspaces/kernel_vivo_mt6765/gcc-32/bin:$PATH"
rm -rf out
mkdir -p out

make O=out ARCH=arm64 \
    CC=clang \
    CLANG_TRIPLE=aarch64-linux-gnu- \
    CROSS_COMPILE=aarch64-linux-android- \
    CROSS_COMPILE_ARM32=arm-linux-androideabi- \
    PD2036F_EX_defconfig && \
make -j$(nproc --all) O=out ARCH=arm64 \
    CC=clang \
    CLANG_TRIPLE=aarch64-linux-gnu- \
    CROSS_COMPILE=aarch64-linux-android- \
    CROSS_COMPILE_ARM32=arm-linux-androideabi- \
    Image
cd out/arch/arm64/boot/
cp Image kernel
gzip -n -9 kernel
