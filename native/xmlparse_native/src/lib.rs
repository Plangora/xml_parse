use rustler::{NifStruct, NifResult};
use libxml::parser;
use libxml::xpath::Context;

#[derive(Debug, NifStruct)]
#[module = "XmlParse.People.Person"]
struct Person {
    name: String,
    age: i64,
}

#[rustler::nif(schedule = "DirtyCpu")]
fn parse(xml_data: String) -> NifResult<Vec<Person>> {
    let parser = parser::Parser::default();
    let doc = parser.parse_string(xml_data).unwrap();
    let mut context = Context::new(&doc).unwrap();
    let person_nodes = context.evaluate("//person").unwrap().get_nodes_as_vec();
    let mut people: Vec<Person> = Vec::with_capacity(person_nodes.len());
    for person_node in person_nodes {
        context.set_context_node(&person_node).unwrap();
        let name = get_text(&context, "./name/text()");
        let age = get_number(&context, "./age/text()");
        people.push(Person { name, age });
    }
    Ok(people)
}

fn get_text(context: &Context, xpath: &str) -> String {
    let object = context.evaluate(xpath).unwrap();
    object.to_string()
}

fn get_number(context: &Context, xpath: &str) -> i64 {
    get_text(context, xpath).parse::<i64>().unwrap()
}

rustler::init!("Elixir.XmlParse.Native", [parse]);
