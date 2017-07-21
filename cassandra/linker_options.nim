when defined(linux):
    {.passL: "-lpthread".}
    {.passL: "-lm".}
    {.passL: "-lstdc++".}
elif defined(macosx):
    {.passL: "-lc++".}

{.passL: "-lcassandra_static".}
{.passL: "-luv".}
