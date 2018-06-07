using System.Collections.Generic;
using Moq;
using WakeItHappen.Service.Constants;

namespace WakeItHappen.Service
{
    public static class Mocks
    {
        public static class For
        {
            public static class RoutPlanner
            {

                public static IRoutePlanner RoutePlanner
                {
                    get
                    {
                        var mock = new Mock<IRoutePlanner>();
                        mock.Setup(x => x.GetTravelTime(It.IsAny<TravelTimeRequest>())).Returns(new TravelRouteResponse
                        {
                            TravelTimeMinutes = 42,
                            TravelStatus = TravelStatus.Delayed,
                            Details = new TravelDetails
                            {
                                Steps = new List<Route>
                                {
                                    new Route
                                    {
                                        OrderId = 1,
                                        From = Poi.Home,
                                        To = Poi.ChiswickParkStaion,
                                        Vehicle = TravelType.Walk
                                    },
                                    new Route
                                    {
                                        OrderId = 2,
                                        From = Poi.ChiswickParkStaion,
                                        To = Poi.Hammersmith,
                                        Vehicle = TravelType.DistrictLine
                                    },
                                    new Route
                                    {
                                        OrderId = 3,
                                        From = Poi.Hammersmith,
                                        To = Poi.Holborn,
                                        Vehicle = TravelType.PicadillyLine,
                                    },
                                    new Route
                                    {
                                        OrderId = 4,
                                        From = Poi.Holborn,
                                        To = Poi.Office,
                                        Vehicle = TravelType.Walk
                                    }
                                    
                                }
                            }
                        });

                        return mock.Object;
                    }
                }
            } 
        }
    }
}