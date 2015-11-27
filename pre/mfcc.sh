# create directory structure
mkdir -p tmp tmp/mfc logs

# generate script files
ls -1d wav/* > tmp/wav_list
sed -e 's/^wav\//tmp\/mfc\//' -e 's/.wav$/.mfc/' tmp/wav_list > tmp/mfc_list
paste tmp/wav_list tmp/mfc_list > tmp/wav2mfc_list

# feature extraction
HCopy -T 3 -C wav2mfcc.conf -S tmp/wav2mfc_list > logs/hcopy.log

