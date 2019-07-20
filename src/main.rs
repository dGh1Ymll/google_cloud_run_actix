use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use std::env;

fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world from cloud run!")
}

fn main() {
    println!("Test test did i starting.....");
    let host = "0.0.0.0:".to_string();
    
    let port = match env::var("PORT") {
        Ok(port) => port.to_string(),
        Err(_) => "8080".to_string(),
    };

    let addr = host + &port;
    println!("Hosting on addres:{}", addr);
    
    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(index))
    })
    .bind(addr)
    .unwrap()
    .run()
    .unwrap();
}
