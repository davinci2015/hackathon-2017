using AutoMapper;
using CoreApi.Attributes;
using CoreApi.Database;
using CoreApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class CleaningController : Controller
    {
        private DatabaseContext db { get; set; }
        private IMapper mapper { get; set; }

        public CleaningController(DatabaseContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }

        [HttpPost("")]
        [JwtAuthorize]
        public async Task<IActionResult> Create([FromBody]CleaningApiModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            var mapped = mapper.Map<Cleaning>(model);
            db.Cleanings.Add(mapped);

            try
            {
                await db.SaveChangesAsync();
            } catch(Exception e)
            {
                Console.WriteLine(e.Message);
                return BadRequest();
            }

            return Ok(mapped);
        }

        [HttpGet("")]
        [JwtAuthorize]
        public async Task<IActionResult> GetAll()
        {
            var all = await db.Cleanings.ToListAsync();

            var mapped = mapper.Map<IEnumerable<CleaningIdApiModel>>(all);

            return Ok(mapped);
        }

        [HttpGet("{id:long}")]
        public async Task<IActionResult> GetSigle(long id)
        {
            var wanted = await db.Cleanings.FirstOrDefaultAsync(x => x.Id == id);

            if (wanted == null)
                return BadRequest();

            var mapped = mapper.Map<CleaningIdApiModel>(wanted);

            return Ok(mapped);
        }
     }
}
