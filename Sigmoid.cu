#include "utils.h"
#include "THCApply.cuh"

struct sigmoidupdateOutput_functor
{
  __device__ void operator()(float* output, const float* input) const
  {
    *output = 1./(1.+ exp(-*input));
  }
};

static int cunn_Sigmoid_updateOutput(lua_State *L)
{
  //double ts = get_ts();
  THCState *state = getCutorchState(L);
  THCudaTensor *input = (THCudaTensor*)luaT_checkudata(L, 2, "torch.CudaTensor");
  THCudaTensor *output = (THCudaTensor*)luaT_getfieldcheckudata(L, 1, "output", "torch.CudaTensor");
  THAssert(THCudaTensor_checkGPU(state, 2, input, output));
  THCudaTensor_resizeAs(state, output, input);
  //double pre_tensor = get_ts() - ts;
  double ts = get_ts();
  THCudaTensor_pointwiseApply2(state, output, input, sigmoidupdateOutput_functor());
  //double tensor = get_ts() - ts;
  //double post_tensor = 0.0;
  double pointwiseApply2_sigmoid = get_ts() - ts;
  //std::cout<<"Sigmoid__pre_tensor|"<<pre_tensor<<std::endl;
  //std::cout<<"Sigmoid__tensor|"<<tensor<<std::endl;
  //std::cout<<"Sigmoid__post_tensor|"<<post_tensor<<std::endl;
  std::cout<<std::fixed<<"pointwiseApply2_sigmoid,"<<pointwiseApply2_sigmoid<<std::endl;
  return 1;
}

struct sigmoidupdateGradInput_functor
{
  __device__ void operator()(float* gradInput, const float* output, const float* gradOutput) const
  {
    *gradInput = *gradOutput * (1.-*output) * *output;
  }
};

static int cunn_Sigmoid_updateGradInput(lua_State *L)
{
  THCState *state = getCutorchState(L);
  THCudaTensor *output = (THCudaTensor*)luaT_getfieldcheckudata(L, 1, "output", "torch.CudaTensor");
  THCudaTensor *gradOutput = (THCudaTensor*)luaT_checkudata(L, 3, "torch.CudaTensor");
  THCudaTensor *gradInput = (THCudaTensor*)luaT_getfieldcheckudata(L, 1, "gradInput", "torch.CudaTensor");
  THAssert(THCudaTensor_checkGPU(state, 3, output, gradOutput, gradInput));
  THCudaTensor_resizeAs(state, gradInput, output);
  THCudaTensor_pointwiseApply3(state, gradInput, output, gradOutput, sigmoidupdateGradInput_functor());
  return 1;
}

static const struct luaL_Reg cunn_Sigmoid__ [] = {
  {"Sigmoid_updateOutput", cunn_Sigmoid_updateOutput},
  {"Sigmoid_updateGradInput", cunn_Sigmoid_updateGradInput},
  {NULL, NULL}
};

void cunn_Sigmoid_init(lua_State *L)
{
  luaT_pushmetatable(L, "torch.CudaTensor");
  luaT_registeratname(L, cunn_Sigmoid__, "nn");
  lua_pop(L,1);
}
