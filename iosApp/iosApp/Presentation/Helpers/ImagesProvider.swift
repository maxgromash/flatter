import Foundation
import SwiftUI

final class ImagesProvider {
    static var buildingTabIcon: Image { Image(systemName: "building.2.fill") }
    static var newsTabIcon: Image { Image(systemName: "newspaper.fill") }
    static var profileTabIcon: Image { Image(systemName: "person.fill") }
    static var buildingBackground: Image { Image("profile_building") }
    static var calendar: Image { Image(systemName: "calendar") }
    static var rightArrow: Image { Image(systemName: "chevron.right") }
    static var walkingPerson: Image { Image(systemName: "figure.walk") }
    static var areaIcon: Image { Image(systemName: "square.dotted") }
    static var documentIcon: Image { Image(systemName: "doc.fill") }
    static var favouritesIcon:  Image { Image(systemName: "star") }
    static var pdfIcon: Image { Image(uiImage: pdfImage) }
    static var favouritesFilledIcon:  Image { Image(systemName: "star.fill") }
    static var editIcon: Image { Image(systemName: "square.and.pencil") }
    static var phoneIcon: Image { Image(systemName: "phone") }
    static var shareIcon: Image { Image(systemName: "square.and.arrow.up") }


    static let newsImagePlaceholder = UIImage(named: "news_image_placeholder")!
    static let projectIcon = UIImage(named: "project_icon")!
    static let flatLayout = UIImage(named: "flat_layout")!
    static let pdfImage = UIImage(named: "pdf_icon")!

    static let firstDubrovskiy = UIImage(named: "first_dubrovskiy")!
    static let symbolProject = UIImage(named: "symbol_project")!

    static let generalPlan = UIImage(named: "general_plan")!

    static func floorLayout(id: Int) -> UIImage {
        UIImage(named: "floor_layout_\(id)")!
    }

    static func flatLayout(id: Int) -> UIImage {
        UIImage(named: "flat_layout_\(id)")!
    }

    static func newsImage(id: Int) -> UIImage {
        UIImage(named: "news_image_\(id)")!
    }
}
