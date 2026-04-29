class_name ItemsDatabase

class Items:
    var name: String
    var description: String
    var icon_id: String

    func _init(p_name, p_description, p_icon_id):
        name= p_name
        description= p_description
        icon_id= p_icon_id

    func get_icon():
        return Bootstrap.asset_database.get_asset(AssetDatabase.IMAGE, icon_id)