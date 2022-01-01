# orbis-sysroot

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/orbisdev/orbis-sysroot/CI?label=CI&logo=github&style=for-the-badge)](https://github.com/orbisdev/orbis-sysroot/actions?query=workflow%3ACI)

The scope of this repo is to prepare the `/usr` folder of the `Orbisdev` toolchain.

Right now it is used to be compiled in the cloud, generating the proper artefacts that later on are downloaded to fulfill the toolchain requirements.

The main magic of these scripts is to have a full C++ support. 
This is achieved compiling the CPP libraries on top of the `sce libc internal`.


## Thanks
