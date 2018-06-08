namespace WakeItHappen.Service
{
    public interface IAlarm
    {
        AlarmRequest CreateAlarm(AlarmData alarmData);
    }
}