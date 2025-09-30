using Microsoft.AspNetCore.Mvc;

namespace DejtingYarp.Controllers;

[ApiController]
[Route("health")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public IActionResult Get() => Ok(new { status = "Healthy", service = "YARP Gateway", timestamp = System.DateTime.UtcNow });
}
