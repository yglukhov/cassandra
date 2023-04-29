when defined(linux):
    {.passL: "-lpthread".}
    {.passL: "-lm".}
    {.passL: "-lstdc++".}
elif defined(macosx):
    {.passL: "-lc++".}

when defined(useDynamic):
  {.passL: "-lcassandra".}
else:
  {.passL: "-lcassandra_static".}

{.passL: "-luv".}
