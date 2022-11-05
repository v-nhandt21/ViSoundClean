import os, pathlib

LOCAL_CHECKPOINTS_DIR = os.path.dirname(os.path.abspath(__file__)) + "/bytesep_data"

def download_checkpoints(args):
     zenodo_dir = "https://zenodo.org/record/5804160/files"
     local_checkpoints_dir = LOCAL_CHECKPOINTS_DIR

     # Download checkpoints.
     checkpoint_names = [
          # "mobilenet_subbtandtime_vocals_7.2dB_500k_steps_v2.pth?download=1",
          # "mobilenet_subbtandtime_accompaniment_14.6dB_500k_steps_v2.pth?download=1",
          "resunet143_subbtandtime_vocals_8.7dB_500k_steps_v2.pth?download=1",
          # "resunet143_subbtandtime_accompaniment_16.4dB_500k_steps_v2.pth?download=1",
     ]

     os.makedirs(local_checkpoints_dir, exist_ok=True)

     for checkpoint_name in checkpoint_names:

          remote_checkpoint_link = os.path.join(zenodo_dir, checkpoint_name)
          local_checkpoint_link = os.path.join(
               local_checkpoints_dir, checkpoint_name.split("?")[0]
          )

          command_str = 'wget -O "{}" "{}"'.format(
               local_checkpoint_link, remote_checkpoint_link
          )
          os.system(command_str)

     # Download and unzip config yaml files.
     remote_zip_scripts_link = os.path.join(zenodo_dir, "train_scripts.zip?download=1")
     local_zip_scripts_path = os.path.join(local_checkpoints_dir, "train_scripts.zip")

     os.system('wget -O "{}" {}'.format(local_zip_scripts_path, remote_zip_scripts_link))
     os.system('unzip "{}" -d {}'.format(local_zip_scripts_path, local_checkpoints_dir))

download_checkpoints(None)