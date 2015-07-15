# Yeast, nandi
python /users/pgreens/git/boosting_2D/run_boosting_2D.py  --num-iter 50  --output-prefix yeast_benchmark_50_sparse --input-format triplet --mult-format sparse -x /srv/persistent/pgreens/projects/boosting/data/yeast_data/motif_hits_MxG.tab.gz -z /srv/persistent/pgreens/projects/boosting/data/yeast_data/reg_exp_ExR.tab.gz -y /srv/persistent/pgreens/projects/boosting/data/yeast_data/target_exp_GxE.tab.gz -g /srv/persistent/pgreens/projects/boosting/data/yeast_data/target_gene_names_G.txt.gz -r /srv/persistent/pgreens/projects/boosting/data/yeast_data/reg_names_R.txt.gz -m /srv/persistent/pgreens/projects/boosting/data/yeast_data/motif_names_M.txt.gz -e /srv/persistent/pgreens/projects/boosting/data/yeast_data/expt_names_E.txt.gz --eta1 0.01 --eta2 0.01 --ncpu 1 --output-path /srv/persistent/pgreens/projects/boosting/results/ --holdout-file /srv/persistent/pgreens/projects/boosting/data/yeast_data/holdout_new.tab --holdout-format triplet --stable

# Hema CD34+, nandi
python /users/pgreens/git/boosting_2D/run_boosting_2D.py --num-iter 1000 --output-prefix hematopoeisis_23K_stable --input-format triplet --mult-format sparse  -x /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/annotationMatrix_full_subset_CD34.txt -z /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/regulatorExpression_full.txt -y /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/accessibilityMatrix_full_subset_CD34.txt -g /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/peak_headers_full_subset_CD34.txt -e /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/cell_types_pairwise.txt -m /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/annotationMatrix_headers_full.txt -r /srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/regulator_names_full.txt --eta1 0.05 --eta2 0.01 --ncpu 1 --output-path /srv/persistent/pgreens/projects/boosting/results/ --stable

# Hema CD34+, nandi, with PRIOR
DATA_PATH=/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/
python /users/pgreens/git/boosting_2D/run_boosting_2D.py --num-iter 500 --output-prefix hematopoeisis_23K_stable_bindingTFsonly --input-format triplet --mult-format sparse  -x $DATA_PATH"annotationMatrix_full_subset_CD34.txt" -z $DATA_PATH"regulatorExpression_bindingTFsonly.txt" -y $DATA_PATH"accessibilityMatrix_full_subset_CD34.txt" -g $DATA_PATH"peak_headers_full_subset_CD34.txt" -e $DATA_PATH"cell_types_pairwise.txt" -m $DATA_PATH"annotationMatrix_headers_full.txt" -r $DATA_PATH"regulator_names_bindingTFsonly.txt" --eta1 0.05 --eta2 0.01 --ncpu 1 --output-path /srv/persistent/pgreens/projects/boosting/results/ --stable --use_prior --prior_input_format matrix --motif_reg_file $DATA_PATH"prior_data/motifTFpriors.txt" --motif_reg_row_labels $DATA_PATH"prior_data/motifTFpriors.rows.txt" --motif_reg_col_labels $DATA_PATH"prior_data/motifTFpriors.columns_gene_only.txt"

