#!/bin/sh
#SBATCH --time=10:00:00   # Run time in hh:mm:ss
#SBATCH --mem-per-cpu=8192      # Maximum memory required per CPU (in megabytes)
#SBATCH --job-name=persisters
#SBATCH --error=persisters.%J.err
#SBATCH --output=persisters.%J.out

###  5_C10, 5_C11, 5_D7, 5_H3 are all low biofilm formers
### 10_F1  10_H5  13_G2  3_B5  5_C4  8_C9 8_A7  9_A2 are all high biofilm formers
cd $WORK/lugdunensis-output/bcfoutput
module load bcftools/1.8

mkdir low
cp 5_C10* ./low
cp 5_C11* ./low
cp 5_H3* ./low
cp 5_D7* ./low
 
mkdir high
cp 10_F1* ./high
cp 10_H5* ./high
cp 13_G2* ./high
cp 3_B5* ./high
cp 5_C4* ./high
cp 8_C9* ./high
cp 8_A7* ./high
cp 9_A2* ./high


bcftools isec $WORK/lugdunensis-output/bcfoutput/low/*.gz -p $WORK/lugdunensis-output/low -n=16;

bcftools isec $WORK/lugdunensis-output/bcfoutput/high/*.gz -p $WORK/lugdunensis-output/high -n=32 ;

bcftools isec $WORK/lugdunensis-output/bcfoutput/*.gz -p $WORK/lugdunensis-output/all -n=48;

sed -i 's/^chr/Chromosome/' $WORK/lugdunensis-output/all/*.vcf; 
sed -i 's/^chr/Chromosome/' $WORK/lugdunensis-output/high/*.vcf; 
sed -i 's/^chr/Chromosome/' $WORK/lugdunensis-output/low/*.vcf; 

