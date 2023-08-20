#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.workflow = 'FBMN'
params.db = 'coconut'

TOOL_FOLDER = "$baseDir/bin"

process chemWalker {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"

    input:
    val taskid 
    val workflow
    val comp
    file db 
    file metfragpath

    output:
    file 'random_walk_output.tsv'

    """
    python $TOOL_FOLDER/ChemWalker/bin/network_walk random-walk --taskid $taskid --workflow $workflow --comp $comp --db $db --metfragpath $metfragpath
    """
}

process plotPanel {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"
    """
    echo "Hello, world!"
    """
}

process plotGraph {
    publishDir "./nf_output", mode: 'copy'

    conda "$TOOL_FOLDER/conda_env.yml"
    """
    echo "Hello, world!"
    """

}

workflow {
    taskid = params.taskid
    workflow = params.workflow
    comp = params.comp
    metfragpath = Channel.fromPath("MetFrag2.3-CL.jar")
    
    if(params.db == 'coconut'){
        db = Channel.fromPath('data/COCONUT.psv')
    } else if (params.db == 'validation') {
        db = Channel.fromPath('data/validation_filtered_db.psv')
    } else {
        db = Channel.fromPath(params.db)
    }
    chemWalker(taskid, workflow, comp, db, metfragpath)
}