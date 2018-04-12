#include "profiler.h"
#include <stdio.h>


int main() {
    int i, gpus;
    struct gpu_props props;

    // display number of present gpus
    gpus = get_num_gpus();
    printf("GPUs present: %i\n", gpus);

    // print info for each gpu
    for (i = 0; i < gpus; i++) {
        get_gpu_data(i, &props);
        printf("GPU index %i - %s\n"
            "\tcompute level: %i.%i\n"
            "\tSMs: %i\n"
            "\tMax threads per SM: %i\n"
            "\tMax blocks per SM: %i\n"
            "\tMax threads per block: %i\n"
            "\tMax threads total: %i\n"
            "\tMax blocks total: %i\n\n",
            i, props.name,
            props.comp_level.major, props.comp_level.minor,
            props.sm_count,
            props.max_sm_threads,
            props.max_sm_blocks,
            props.max_block_size,
            props.max_total_threads,
            props.max_total_blocks);
    }

    return 0;
}
