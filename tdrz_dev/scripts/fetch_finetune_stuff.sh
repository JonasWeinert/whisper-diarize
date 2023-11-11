#!/bin/sh

# setup for azcopy https://aka.ms/downloadazcopy-v10-linux, much faster download than wget
if ! command -v azcopy &> /dev/null
then
    echo "azcopy could not be found, installing"
    wget https://aka.ms/downloadazcopy-v10-linux -O azcopy.tar.gz
    tar -zxvf azcopy.tar.gz -C $PWD
    AZCOPY_DIR=$(realpath $(ls -d $PWD/azcopy_linux*))
    export PATH=$PATH:$AZCOPY_DIR
    echo "Fetched executable at $AZCOPY_DIR"
fi

cd ..

WORKDIR=$PWD/workdir_finetune

# Create the workdir_finetune and datasets directories
mkdir -p $WORKDIR/datasets

# Change the commands to use the datasets directory
azcopy cp https://sharedstorage7190.blob.core.windows.net/tinydiarize/precomputed/tdrz_ft_ami_prepared-hf_datasets.tar.gz $WORKDIR/datasets/
tar -zxvf $WORKDIR/datasets/tdrz_ft_ami_prepared-hf_datasets.tar.gz -C $WORKDIR/datasets
echo "Fetched finetuning dataset"

cd ../../scripts
