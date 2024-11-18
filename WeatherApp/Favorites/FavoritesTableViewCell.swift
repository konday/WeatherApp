import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    private let cityView = FavoritesCustomCellViews()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(cityView)
        cityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            cityView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cityView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with model: CityModel) {
        cityView.setup(model: model)
    }
}
