''' 
@begin NYPL_Data_Cleaning_Outer_Workflow @desc Team 208 Phase II data cleaning outer workflow
@in NYPL_dataset_D
@in NYPL_use_case_U1
@out comparison_summary_table
@out comparison_summary_table_columns_changed_count
@out comparison_summary_table_cells_per_column_changed_count
@out comparison_summary_table_IC_enforced_changed_count
@out overall_outer_workflow
@out overall_inner_workflow
@out NYPL_dataset_D
@out cleaned_NYPL_dataset_D'
@out in_ZIP_workflow_model
@out in_ZIP_operation_history
@out queries @desc what questions are trying to be answered
@out url_box_folder_link @uri https://placeholder


@begin describe_NYPL_dataset_D_S1 @desc Description of dataset D and matching use case U1 (Extract)
@in NYPL_dataset_D
@in NYPL_use_case_U1
@out NYPL_dataset_D_required_attributes @desc attributes required and the reason it is required
@out NYPL_dataset_D_original_metadata @desc column numbers, rows, number of null/NAN/empty rows in term of percentage of schema total row
@end describe_NYPL_dataset_D_S1 




@begin profiling_of_NYPL_dataset_D_S2 @desc Profiling of D to identify the quality problems P (Extract), including IC violation discovery
@in NYPL_dataset_D
@in NYPL_dataset_D_required_attributes
@out quality_problems_P @desc data quality problem identification based on NYPL_dataset_D_required_attributes
@out functional_dependencies @desc determine schema functional dependencies based on best of knowledge
@end profiling_of_NYPL_dataset_D_S2 


@begin data_cleaning_S3 @desc data cleaning steps performed on NYPL_dataset_D
@in NYPL_dataset_D
@in NYPL_dataset_D_required_attributes
@in quality_problems_P
@in functional_dependencies
@out cleaned_NYPL_dataset_D' @desc cleaned NYPL_dataset_D, addressed as cleaned_NYPL_dataset_D'
@out NYPL_dataset_D'_metadata
@out OpenRefine_recipe
@out other_scripts_provenance_files
@end data_cleaning_S3


@begin comparison_dataset_D'_and_D_S4 @desc data cleaning steps performed on NYPL_dataset_D
@in cleaned_NYPL_dataset_D'
@in NYPL_dataset_D'_metadata
@in NYPL_dataset_D
@in NYPL_dataset_D_original_metadata
@out comparison_summary_table
@out comparison_summary_table_columns_changed_count
@out comparison_summary_table_cells_per_column_changed_count
@out comparison_summary_table_IC_enforced_changed_count
@end comparison_dataset_D'_and_D_S4


@begin provenance_and_documentation_of_dataset_D'_and_D_S5 @desc data cleaning steps performed on NYPL_dataset_D
@in NYPL_dataset_D_original_metadata
@in cleaned_NYPL_dataset_D'
@in NYPL_dataset_D
@out overall_outer_workflow
@out overall_inner_workflow
@end provenance_and_documentation_of_dataset_D'_and_D_S5


@begin supplementary_materials @desc submission of supplementary materials in a single ZIP file
@in overall_outer_workflow
@in overall_inner_workflow
@out in_ZIP_workflow_model

@in OpenRefine_recipe
@in other_scripts_provenance_files @desc including logica, duckDB
@out in_ZIP_operation_history

@in NYPL_use_case_U1
@out queries @desc what questions are trying to be answered

@in NYPL_dataset_D
@in cleaned_NYPL_dataset_D'
@out url_box_folder_link @uri https://placeholder
@end supplementary_materials


@end NYPL_Data_Cleaning_Outer_Workflow
'''