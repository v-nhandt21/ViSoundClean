INPUT_DIR=${1}
OUTDIR=${2}
MODEL_ENHANCEMENT=${3}

CUR="$PWD"

TMP=$CUR/tmp

mkdir -p $TMP
################################################## Demucs: 16kwav=>16kwav

if [[ $MODEL_ENHANCEMENT == "demucs" ]] || [[ $MODEL_ENHANCEMENT == "all" ]];
then

for i in $INPUT_DIR/*.wav;
     do sox $i -r 16000 ${i%.wav}_rs.wav;
done
mv $INPUT_DIR/*_rs.wav $TMP

cd Demucs/denoiser

python -m denoiser.enhance \
--model_path $CUR/Demucs/best.th \
--noisy_dir $TMP \
--out_dir $OUTDIR/Demucs

rm -r $TMP/*

cd ../..
fi

################################################## vocal remover wav44k=>44kwav

if [[ $MODEL_ENHANCEMENT == "vocalremover" ]] || [[ $MODEL_ENHANCEMENT == "all" ]];
then

for i in $INPUT_DIR/*.wav;
     do sox $i -r 44100 ${i%.wav}_rs.wav;
done
mv $INPUT_DIR/*_rs.wav $TMP

cd vocal-remover

python inference.py \
-i $TMP \
-o $OUTDIR/VocalRemover

rm -r $TMP/*

cd ..
fi

################################################## Full subnet 16kwav=>16kwav

if [[ $MODEL_ENHANCEMENT == "fullsubnet" ]] || [[ $MODEL_ENHANCEMENT == "all" ]];
then

for i in $INPUT_DIR/*.wav;
     do sox $i -r 16000 ${i%.wav}_rs.wav;
done
mv $INPUT_DIR/*_rs.wav $TMP

cd Fullsubnet/FullSubNet-plus

python -m speech_enhance.tools.inference \
-C config/inference.toml \
-M $CUR/Fullsubnet/best_model.tar \
-I $TMP \
-O $OUTDIR/Fullsubnet

rm -r $TMP/*

cd ../..
fi

################################################## Music Source Separation 44kMp3 => 44kMp3

if [[ $MODEL_ENHANCEMENT == "bytedance" ]] || [[ $MODEL_ENHANCEMENT == "all" ]];
then

cd ByteDance/music_source_separation

for i in $INPUT_DIR/*.wav;
     do sox "$i" -r 44100 "${i%.wav}_rs.wav";
     ffmpeg -i "${i%.wav}_rs.wav" -ac 2 "${i%.wav}.mp3" ;
done
mv $INPUT_DIR/*.mp3 $TMP
rm $INPUT_DIR/*_rs.wav 

python -m bytesep separate \
--source_type="vocals" \
--audio_path=$TMP \
--output_path=$OUTDIR/ByteDance \
--scale_volume

rm -r $TMP/*

cd ../..
fi

######################################## Convert to 22k wav

if [[ $MODEL_ENHANCEMENT != "bytedance" ]] || [[ $MODEL_ENHANCEMENT == "all" ]];
then
for i in $OUTDIR/*/*_rs.wav;
     do sox $i -r 44100 ${i%_rs.wav}.wav;
done
fi

rm -r $TMP
rm $OUTDIR/*/*_rs.wav