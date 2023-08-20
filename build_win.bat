@echo off

cl /c wrapper_cpp\wrapper.cpp /O2

lib /OUT:wrapper.lib wrapper.obj

del wrapper.obj