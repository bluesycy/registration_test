#!/bin/bash
REF_PATH="20231013_191710_ref_2678_2805.nrrd"
DATA_PATH="20231013_191710_ref_19414_19584.nrrd"

cmtk make_initial_affine --principal-axes $REF_PATH $IMG_PATH initial.list

echo "registration"
cmtk registration --initial initial.list --nmi --dofs 6 --exploration 8 --accuracy 0.8 -o affine.list $REF_PATH $IMG_PATH

cmtk xform2dfield deform_field.nrrd $REF_PATH affine.list

cmtk reformatx -o --target-grid 100,100,100:1.0,1.0,1.0 result_deform.nrrd --floating $IMG_PATH deform_field.nrrd

cmtk reformatx -o result_deform.nrrd --floating $IMG_PATH $REF_PATH affine.list