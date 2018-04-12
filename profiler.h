#ifndef _PROFILER_H
#define _PROFILER_H

struct compute_level {
    int major, minor;
};

struct gpu_props {
    struct compute_level comp_level;
    int gpu_index, sm_count, max_sm_threads, max_sm_blocks,
        max_block_size, max_total_threads, max_total_blocks;
    char name[256];
};

int get_num_gpus();

void get_gpu_data(int gpu_index, struct gpu_props *props);

#endif
