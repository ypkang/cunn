#include "utils.h"

THCState* getCutorchState(lua_State* L)
{
    lua_getglobal(L, "cutorch");
    lua_getfield(L, -1, "getState");
    lua_call(L, 0, 1);
    THCState *state = (THCState*) lua_touserdata(L, -1);
    lua_pop(L, 2);
    return state;
}

double get_ts()
{
  auto ts = std::chrono::high_resolution_clock::now();
  double ts_time = std::chrono::duration_cast<std::chrono::microseconds>(ts.time_since_epoch()).count();
  return ts_time/1000.0;
}
