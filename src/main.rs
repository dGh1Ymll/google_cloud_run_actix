use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use std::env;

fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

fn main() {
    
    let mut host = "127.0.0.1:".to_string();


    match env::var("PORT") {
        Ok(port) => {
            host = host + &port.to_string();
            println!("Localhost and port: {}", host);
        }
        Err(e) => println!("Couldn't read PORT ({})", e),
    };

    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(index))
    })
    .bind(host)
    .unwrap()
    .run()
    .unwrap();
}
