﻿using System;

namespace WakeItHappen.Service
{
    public class CityMapperRequest
    {
        public Coordinate Start { get; set; }
        public Coordinate End { get; set; }
        public DateTime Time { get; set; }
    }
}