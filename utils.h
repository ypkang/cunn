#ifndef CUNN_UTILS_H
#define CUNN_UTILS_H

extern "C"
{
#include <lua.h>
}
#include <luaT.h>
#include <THC/THC.h>
#include <chrono>
#include <iostream>

THCState* getCutorchState(lua_State* L);

void cunn_SpatialCrossMapLRN_init(lua_State *L);
void cunn_Tanh_init(lua_State *L);
void cunn_Sigmoid_init(lua_State *L);
void cunn_SoftMax_init(lua_State *L);
void cunn_TemporalConvolution_init(lua_State *L);
void cunn_TemporalMaxPooling_init(lua_State *L);
void cunn_SpatialBatchNormalization_init(lua_State *L);
void cunn_SpatialConvolutionMM_init(lua_State *L);
void cunn_SpatialConvolutionLocal_init(lua_State *L);
void cunn_SpatialFullConvolution_init(lua_State *L);
void cunn_SpatialMaxPooling_init(lua_State *L);
void cunn_SpatialMaxUnpooling_init(lua_State *L);
void cunn_SpatialFractionalMaxPooling_init(lua_State *L);
void cunn_SpatialAdaptiveMaxPooling_init(lua_State *L);
void cunn_SpatialSubSampling_init(lua_State *L);
void cunn_SpatialAveragePooling_init(lua_State *L);
void cunn_MultiMarginCriterion_init(lua_State *L);
void cunn_MarginCriterion_init(lua_State *L);
void cunn_Square_init(lua_State *L);
void cunn_Sqrt_init(lua_State *L);
void cunn_Threshold_init(lua_State *L);
void cunn_MSECriterion_init(lua_State *L);
void cunn_SmoothL1Criterion_init(lua_State *L);
void cunn_SoftPlus_init(lua_State *L);
void cunn_SoftShrink_init(lua_State *L);
void cunn_SpatialUpSamplingNearest_init(lua_State *L);
void cunn_VolumetricConvolution_init(lua_State *L);
void cunn_VolumetricFullConvolution_init(lua_State *L);
void cunn_VolumetricMaxPooling_init(lua_State *L);
void cunn_VolumetricAveragePooling_init(lua_State *L);
void cunn_PReLU_init(lua_State *L);
void cunn_RReLU_init(lua_State *L);

double get_ts();

#endif
