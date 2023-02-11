# Set Up Mac for Data Science with Emacs

## Homebrew

``` shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

## TensorFlow

- Download the installation shell script for [miniforge](https://github.com/conda-forge/miniforge) for MacOS, either [x86_64](https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-x86_64.sh) or [arm65](https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh).
- Run the script and enter the virtual environment, e.g.,

``` shell
% sh ~/Downloads/Miniforge3-MacOSX-arm64.sh
% source ~/miniforge3/bin/activate
```

- On Apple Silicon, with Metal support.

``` shell
conda install -c apple tensorflow-deps
pip install tensorflow-macos
pip install tensorflow-metal
```

- On Intel, without GPU acceleration

``` shell
pip install tensorflow
```

