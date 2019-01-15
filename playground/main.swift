import Foundation

struct User {
//     let name: String
    let id: Int
}


        class NewTopic :Codable{
            var name: String
            var content: String
            var authorId: String
            var cursusId: [String]
            var kind: String
            var language_id: String
            var message_attributes: [String:String]
            var tags_ids : [String]
            init(name:String, content: String, user:User) {
                self.name = name
                self.content = content
                self.authorId = user.id.description
                self.cursusId = ["1"]
                self.language_id = "1"
                self.kind = "normal"
                self.message_attributes = ["author_id":user.id.description,"content": content, "messageable_id": "1", "messageable_type": "Topic"]
                self.tags_ids = ["9"]
            }
        }

func topicPost(name: String, content: String, user:User) -> NewTopic {
       return NewTopic(name: name, content: content, user: user) 
}

    var person = topicPost(name: "coucou", content: "content", user: User(id: 1234))

    let payload: Data = try JSONEncoder().encode(person)
