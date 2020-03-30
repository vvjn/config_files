curl -o ./miniconda.sh -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ./miniconda.sh && \
     ./miniconda.sh -b -p /home/vvijayan/opt/conda && \
     rm ./miniconda.sh

#    /home/vvijayan/opt/conda/bin/conda install conda=4.6.14
/home/vvijayan/opt/conda/bin/conda init bash

/home/vvijayan/opt/conda/bin/conda config --set allow_conda_downgrades true

/home/vvijayan/opt/conda/bin/conda create -y --name modis anaconda keras-gpu tensorflow-gpu gdal opencv jedi flake8 autopep8 yapf black rope progressbar2 python-utils nodejs && \
 /home/vvijayan/opt/conda/bin/conda install -y --name modis r-base r-essentials && \
 /home/vvijayan/opt/conda/bin/conda install -y --name modis torchvision cudatoolkit=10.1 -c pytorch 

echo "conda activate modis" >> .bashrc
