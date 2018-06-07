namespace WakeItHappen.Service
{
    public interface IRoutePlanner
    {
        TravelRouteResponse GetTravelTime(TravelTimeRequest request);
        TravelRouteResponse GetTravelTimeWithDetails(TravelTimeRequest request);
    }
}