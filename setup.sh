
###
python -m pip install torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html

### ByteDance

cd ByteDance
python -m pip install -r music_source_separation/requirements.txt
python download_model.py
cd ..

### Demus
python -m pip install -r Demucs/denoiser/requirements.txt

### vocal-remover
python -m pip install -r vocal-remover/requirements.txt

### Fullsubnet
python -m pip install -r Fullsubnet/FullSubNet-plus/requirements.txt

python -m pip install hydra-core --upgrade