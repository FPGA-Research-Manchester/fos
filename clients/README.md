# Daemon Clients

Communication between clients and the daemon is setupped via a gRPC call which passes the accelerator name and parameters. 
Simple client examples in [C++](./simple_cpp) and [python](./simple_py) clients can be found in this directory along with 
the [client used for the demo at FPL 2019](./wxmonitor). 

## Usage: Standard Flow
1. Create GRPC Client
```C++
  // get fpga rpc client instance
  FPGARPCClient fpgaRpc;
```

2. Ask daemon for which buffer is free to use
```C++
  // get free udma buffer from daemon
  UdmaRepo repo;
  int bufno = fpgaRpc.Alloc();
  if (bufno < 0) throw std::runtime_error("Failed to get buffer from daemon");
  UdmaDevice *device = repo.device(bufno);
```

3. Setup buffer 
```C++
  // get pointer to contiguous physical memory buffer
  char *buf0 = device->map();
  // get physical address of buffer 
  uint64_t buf0addr = device->phys_addr;
  // Copy the data over as needed
  memcpy(buf0, input.data, size);
```
4. Create an accelertion job and set the parameters

```C++
  std::vector<Job> jobs;              // create list of jobs
  Job& job = jobs.emplace_back();     // add job
  job.accname = "Partial_sobel";      // set accelerator name
  job.params["in_pixels"]      = bot32(buf0addr);
  job.params["in_pixels_msb"]  = top32(buf0addr);
  job.params["out_pixels"]     = bot32(buf1addr);
  job.params["out_pixels_msb"] = top32(buf1addr);
  job.params["im_width"]       = width;
  job.params["im_height"]      = height;
```

5. Launch the job to the daemon

```C++
  fpgaRpc.Run(jobs);                  // send the jobs to the daemon
```

6. Free the buffer

```C++
  device->unmap();
  fpgaRpc.Free(bufno);
```

