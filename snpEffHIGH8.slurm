#!/bin/sh
#SBATCH --time=20:00:00   # Run time in hh:mm:ss
##SBATCH --mem-per-cpu=8192       # Maximum memory required per CPU (in megabytes)
#SBATCH --job-name=snpeff
#SBATCH --error=snpeff.%J.err
#SBATCH --output=snpeff.%J.out
################################################################
###  5_C10, 5_D7, 5_H3 are all low biofilm formers
### 10_F1  10_H5  13_G2  3_B5  5_C4  8_C9 8_A7  9_A2 are all high biofilm formers
cd $WORK/lugdunensis-output/bcfoutput
module load bcftools/1.8

mkdir HIGH8
cp 10_F1* ./HIGH8
cp 10_H5* ./HIGH8
cp 13_G2* ./HIGH8
#cp 3_B5* ./HIGH8
cp 5_C4* ./HIGH8
cp 8_C9* ./HIGH8
cp 8_A7* ./HIGH8
cp 9_A2* ./HIGH8 
mkdir ALL8
cp 10_F1* ./ALL8
cp 10_H5* ./ALL8
cp 13_G2* ./ALL8
#cp 3_B5* ./ALL8
cp 5_C4* ./ALL8
cp 8_C9* ./ALL8
cp 8_A7* ./ALL8
cp 9_A2* ./ALL8
cp 5_C11* ./ALL8
cp 5_C10* ./ALL8
cp 5_H3* ./ALL8
cp 5_D7* ./ALL8

bcftools isec $WORK/lugdunensis-output/bcfoutput/HIGH8/*.gz -p $WORK/lugdunensis-output/HIGH8 -n=28;

bcftools isec $WORK/lugdunensis-output/bcfoutput/ALL8/*.gz -p $WORK/lugdunensis-output/ALL8 -n=44;

sed -i 's/^chr/Chromosome/' $WORK/lugdunensis-output/ALL8/*.vcf; 
sed -i 's/^chr/Chromosome/' $WORK/lugdunensis-output/HIGH8/*.vcf; 
#############################################################
module load java/1.8
cd $WORK/lugdunensis-output/snpEff/
mkdir HIGH8
cd HIGH8
mkdir snpEff-gene
mkdir snpEff-summary
cd $WORK/lugdunensis
java -Xmx4g -jar $WORK/lugdunensis-softwares/snpEff/snpEff.jar -v Staphylococcus_lugdunensis_n920143 $WORK/lugdunensis-output/ALL8/0000.vcf > $WORK/lugdunensis-output/snpEff/HIGH8/snpEff-AllHIGH8-0.ann.vcf;
mv $WORK/lugdunensis/snpEff_genes.txt $WORK/lugdunensis-output/snpEff/HIGH8/snpEff-gene/all-HIGH8-0-genes.txt;
mv $WORK/lugdunensis/snpEff_summary.html $WORK/lugdunensis-output/snpEff/HIGH8/snpEff-summary/all-HIGH8-0-summary.html;

######################################### highs######################

java -Xmx4g -jar $WORK/lugdunensis-softwares/snpEff/snpEff.jar -v Staphylococcus_lugdunensis_n920143 $WORK/lugdunensis-output/HIGH8/0000.vcf > $WORK/lugdunensis-output/snpEff/HIGH8/snpEff-HIGH8-0.ann.vcf;
mv $WORK/lugdunensis/snpEff_genes.txt $WORK/lugdunensis-output/snpEff/HIGH8/snpEff-gene/HIGH8-0-genes.txt;
mv $WORK/lugdunensis/snpEff_summary.html $WORK/lugdunensis-output/snpEff/HIGH8/snpEff-summary/HIGH8-0-summary.html;


