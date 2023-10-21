#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.workflow = 'FBMN'
params.db = 'COCONUT'
params.savegraph=1
// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"
params.publishdir = "./nf_output"
TOOL_FOLDER = "$baseDir/bin"

process chemWalker {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"

    input:
    val taskid 
    val workflow
    val comp
    val savegraph
    path db
    path metfragpath
    

    output:
    path 'random_walk_output.tsv'
    path 'random_walk_output.graphml'

    """
    python $TOOL_FOLDER/ChemWalker/bin/network_walk random-walk --taskid $taskid --workflow $workflow --comp $comp  --savegraph $savegraph --db $db --metfragpath $metfragpath
    """
}

workflow {
    taskid = params.taskid
    workflow = params.workflow
    comp = params.comp
    savegraph = params.savegraph
    metfragpath = Channel.fromPath("$TOOL_FOLDER/ChemWalker/bin/MetFrag2.3-CL.jar")
    
    db = Channel.fromPath(params.user_db)
    chemWalker(taskid, workflow, comp, savegraph, db, metfragpath)
}