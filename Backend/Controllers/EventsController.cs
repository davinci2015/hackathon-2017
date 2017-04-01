using AutoMapper;
using CoreApi.Attributes;
using CoreApi.Database;
using CoreApi.Helpers.Extensions;
using CoreApi.Models;
using CoreApi.Models.ApiModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class EventsController: Controller
    {
        private UserManager<User> userManager { get; set; }
        private IMapper mapper { get; set; }
        private DatabaseContext db { get; set; }

        public EventsController(DatabaseContext db, IMapper mapper, UserManager<User> userManager)
        {
            this.mapper = mapper;
            this.userManager = userManager;
            this.db = db;
        }

        [HttpGet("")]
        public async Task<IActionResult> GetAll()
        {
            var events = await db.Events.Include(x => x.EventUsers)
                .ToListAsync();

            var mappedd = mapper.Map<IEnumerable<EventsApiModel>>(events);

            return Ok(mappedd);
        }

        [HttpPost("")]
        [JwtAuthorize]
        public async Task<IActionResult> Create([FromBody]CreateEventApiModel model)
        {
            if (ModelState.IsValid)
            {
                var mapped = mapper.Map<Event>(model);
                var user = await userManager.FindByIdAsync(User.FindFirst(ClaimTypes.NameIdentifier).Value);

                mapped.CreatedBy = $"{user.Name} {user.Surname}";
                mapped.StartDate = DateTimeOffset.Now;

                db.Events.Add(mapped);
                await db.SaveChangesAsync();

                return Ok(mapper.Map<EventsApiModel>(mapped));
            }

            return BadRequest();
        }

        [HttpPost("join/{id:long}")]
        [JwtAuthorize]
        public async Task<IActionResult> Join(long id)
        {
            var ev = await db.Events.FirstAsync(x => x.Id == id);
            var user = await userManager.FindByIdAsync(User.FindFirst(ClaimTypes.NameIdentifier).Value);

            ev.EventUsers.Add(new EventsUsers
            {
                User = user
            });

            try
            {
                await db.SaveChangesAsync();
            } catch(Exception e)
            {
                Console.WriteLine(e.Message);
                return BadRequest(new { Error = "User already present on this activity" });
            }

            var mapped = mapper.Map<EventsApiModel>(ev);
            
            return Ok(mapped);
        }

        [HttpPut("{nfc}")]
        public async Task<IActionResult> GivePoints(string nfc)
        {
            if (nfc == null)
                return BadRequest();

            var user = await db.Users.FirstAsync(x => x.Nfc == nfc);

            if (user == null)
                return BadRequest();

            user.Money += 50;

            try
            {
                await db.SaveChangesAsync();
            } catch(Exception e)
            {
                Console.WriteLine(e);
                return BadRequest();
            }

            var mapped = mapper.Map<UserApiModel>(user);

            return Ok(mapped);
        }
    }
}
