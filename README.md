# Denoiser and Enhancement for TTS processing

### Setup

Create new conda environment

```conda create -n denoise python=3.8```

```conda activate denoise```

```conda install pip```

Then run setup script to install necessary libraries

```bash setup.sh```

### Inference

```bash get_enhance.sh <INPUT_DIR> <OUTDIR> <MODEL_ENHANCEMENT>```

*INPUT_DIR*                   : directory of noised audios

*OUTDIR*                      : directory for clean output audios

*MODEL_ENHANCEMENT*           : available model: 

- "all" 

- "voiceremover" 

- "demucs" 

- "fullsubnet" 

- "bytedance"

Example:

```bash get_enhance.sh /home/nhandt23/Desktop/DenoiseEnhance/sample_demo/noised_data /home/nhandt23/Desktop/DenoiseEnhance/sample_demo/clean_data vocalremover```