################################################################################
# 0. Paths and variables
################################################################################
# 0.1 Paths
# ------------------------------------------------------------------------------
WD="$HOME/git/sim-molluscs"
SIM_MOLLUSCS_SRC="$WD/src"
SIM_MOLLUSCS_FILES="$WD/files"
SIM_MOLLUSCS_REPORT="$WD/report"
SIM_MOLLUSCS_OUTPUT="$WD/output"
SIM_MOLLUSCS_SETTINGS="$WD/data/settings"
SIM_MOLLUSCS_TREES="$WD/data/trees"
SIM_MOLLUSCS_SEQUENCES="$WD/data/sequences"
SIM_MOLLUSCS_CONTROL="$WD/data/control"
# ------------------------------------------------------------------------------
# 0.2 Variables
# ------------------------------------------------------------------------------
SIM_MOLLUSCS_RANDOM=311202566
DIVERSITY=( "01" "05" "10" "20" )
SEQUENCES=( "$SIM_MOLLUSCS_SEQUENCES/sequence.1.fasta" "$SIM_MOLLUSCS_SEQUENCES/sequence.2.fasta")
CONTROL_FILES=( "$SIM_MOLLUSCS_CONTROL/indelible.control.pav.1.txt" "$SIM_MOLLUSCS_CONTROL/indelible.control.pav.2.txt" "$SIM_MOLLUSCS_CONTROL/indelible.control.pav.3.txt")
################################################################################
# 1. Generating folder structure for all datasets-
# SX_DY
# - Where X, corresponds to the sequence used
#   - 1: Sequence.1.fasta - HSP90
#   - 2: Sequence.2.fasta - adhesion protein mytilus galloprovincialis
#   - 3: SIMULATED
# - Where y, corresponds to the diversity used
#   - 1: 0.01
#   - 2: 0.05
#   - 3: 0.1
#   - 4: 0.2
################################################################################
seq=0; div=0; ctrl=0
for seq in $(seq 0 2) ;do
        for div in $(seq 0 3);do
            currentDiversity=${DIVERSITY[div]}
            currentSequence=${SEQUENCES[seq]}
            currentControl=${CONTROL_FILES[seq]}
            folder="${SIM_MOLLUSCS_OUTPUT}/S${seq}_D${currentDiversity}"
            echo $folder
            mkdir ${folder}
            ################################################################################
            # 1. S1_D1
            #-------------------------------------------------------------------------------
            cd ${folder}
            if [[ $seq -lt 2 ]]; then
                cp ${currentSequence} sequence.fasta
                cp ${SIM_MOLLUSCS_SETTINGS}/ngsphy.pav.txt ngsphy.settings.txt
            else
                cp ${SIM_MOLLUSCS_SETTINGS}/ngsphy.pav.2.txt ngsphy.settings.txt
            fi
            cp ${currentControl} control.txt
            cp ${SIM_MOLLUSCS_TREES}/tree.${currentDiversity}.txt tree.tree
            ngsphy -s ngsphy.settings.txt
        done
done


<<TOCHECK
1. Simulated sequences match the given sequence for outputs S0* and S1*
2. Simulated sequences in mode S2* match along diversity modes D*
3. Check nucleotide diversity (to correspond with given diversity in the indelible's control files)
TOCHECK
