using Microsoft.AspNetCore.Mvc;
using WakeService.ViewModels;

namespace WakeService.Controllers
{
    [Route("api/WakeItHappen")]
    public class WakeControiller : Controller
    {
        [HttpGet("IsDelayed/{alarmId}")]
        public IActionResult IsDelayed(int alarmId)
        {
            //returns if there is a delay and how much by
            
            var conn = new Database.PostgresSqlConnection().GetConnection();
            return Json(new VmDelay() {IsDelayed = false, DelayedByMinutes = 0});
            
        }
        
        [HttpPost("CreateWakeUp")]
        public IActionResult CreateWakeUp(VmAlarmDetails details)
        {
            //returns the alarm Id after saving
            return Json(1);
        }
        
        

    }
}