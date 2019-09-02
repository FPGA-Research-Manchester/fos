#!/usr/bin/env python3

import grpc
import proto.fpga_rpc_pb2 as fpga_msg
import proto.fpga_rpc_pb2_grpc as fpga_rpc

class Client:
  def __init__(self):
    self.connect_uri = 'localhost:50051'
    self.channel = grpc.insecure_channel(self.connect_uri)
    self.stub = fpga_rpc.FPGARPCStub(self.channel)

  def Alloc(self):
    response = self.stub.Alloc(fpga_msg.AllocMessage())
    return response.bufno

  def Free(self, bufno):
    response = self.stub.Free(fpga_msg.FreeMessage(bufno=bufno))

  def Run(self, jobs):
    wiremsgs = [fpga_msg.AccJob(AccName=job["name"], PerName="", Parameters=job["params"]) for job in jobs]
    response = self.stub.Run(fpga_msg.RunMessage(Jobs=wiremsgs))
