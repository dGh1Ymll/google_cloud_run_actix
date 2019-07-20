use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use std::env;

fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world from cloud run!")
}

fn main() {
    let mut host = "0.0.0.0:".to_string();
    match env::var("PORT") {
        Ok(port) => {
            host = host + &port.to_string();
            println!("Localhost and port: {}", host);
        }
        Err(e) => {
            println!("Couldn't read the PORT number ({})", e);
            host = host + &"8080".to_string();
        }
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
