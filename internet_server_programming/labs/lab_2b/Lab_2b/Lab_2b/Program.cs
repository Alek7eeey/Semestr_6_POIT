var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
	app.UseExceptionHandler("/Home/Error");
	// The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
	app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
	name: "M01",
	pattern: "/{MResearch?}/{action}/{id?}",
	defaults: new { controller = "MResearch", action = "M01" },
	constraints: new { MResearch = "MResearch", action = "M01|M02", id = new Lab_2b.CustomValid() }
);

app.MapControllerRoute(
	name: "V2",
	pattern: "V2/{MResearch?}/{action}",
	defaults: new { controller = "MResearch", action = "M02" },
	constraints: new { action = "M01|M02", MResearch = "MResearch" }
);

app.MapControllerRoute(
	name: "V3",
	pattern: "V3/{MResearch?}/{str}/{action}",
	defaults: new { controller = "MResearch", action = "M03", value = "" },
	constraints: new { action = "M01|M02|M03", MResearch = "MResearch" }
);

app.MapControllerRoute(
	name: "MXX",
	pattern: "{*uri}",
	defaults: new { controller = "MResearch", action = "MXX" });

/*
app.MapControllerRoute(
    name: "V2",
    pattern: "V2/{controller}/{action}",
    defaults: new { controller = "MResearch", action = "M02" });

app.MapControllerRoute(
    name: "V3",
    pattern: "V3/{controller}/{str?}/{action}",
    defaults: new { controller = "MResearch", action = "M03" });

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=MResearch}/{action=M01}/{id?}");

app.MapControllerRoute(
    name: "default",
    pattern: "{*uri}",
    defaults: new { controller = "MResearch", action = "MXX" }
);

*/
app.Run();
