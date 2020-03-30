# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vvijayan/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vvijayan/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/home/vvijayan/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/vvijayan/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate modis

#

conda install -y pytorch torchvision cudatoolkit=10.1 -c pytorch && \
conda install -y anaconda gdal opencv jedi flake8 autopep8 \
      yapf black rope progressbar2 descartes palettable python-utils \
      nodejs keras-gpu tensorflow-gpu=1.15.0 gast=0.2.2 && \
conda clean -ya
