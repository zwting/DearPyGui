@echo off

set dir=%~dp0

cd ..
mkdir cmake-build-local
cd cmake-build-local

cmake .. -G "Visual Studio 16 2019" -A "x64" -DMVDIST_ONLY=True -DMVPY_VERSION=0 -DMVDPG_VERSION=local_build
cd ..
cmake --build cmake-build-local --config "Release"

if not exist "%dir%..\venv\Scripts\python.exe" (
    call ".\Dependencies\cpython\PCbuild\amd64\python.exe" -m venv %dir%..\venv
)

set python39="%dir%..\venv\Scripts\python.exe"

echo Generate core.pyi...
cd %dir%..\cmake-build-local\DearSandbox
call DearSandbox.exe --gen-pyi
cd %dir%..\
echo Generate core.pyi success!!

cd Distribution
call %python39% BuildPythonWheel.py ..\cmake-build-local\DearPyGui\Release\core.pyd 0
call %python39% -m ensurepip
call %python39% -m pip install --upgrade pip
call %python39% -m pip install twine
call %python39% -m pip install wheel
call %python39% -m setup bdist_wheel --plat-name win_amd64 --dist-dir ../dist
xcopy dearpygui ..\venv\Lib\site-packages\dearpygui\ /E /Y 
cd ..
cd Scripts

