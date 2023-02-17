//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Sam on 03/02/2023.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character:RMCharacter)
}
  
// View model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [RMCharacter] = []{
        didSet{
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
            
                cellViewModel.append(viewModel)
            }
        }
    }
    private var cellViewModel: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (20)
   public func fetchCharacters(){
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self
        ){[weak self] result in
            
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
    
    /// Paginate if aditional characters are needed
    public func fetchAdditionalCharacters(url: URL){
        isLoadingMoreCharacters = true
        RMService.shared.execute(
            RMRequest,
            expecting: <#T##(Decodable & Encodable).Protocol#>,
            completion: <#T##(Result<Decodable & Encodable, Error>) -> Void#>)
    }
    
    public var shouldShowLoadMoreIndicator:Bool{
        return apiInfo?.next != nil
    }
}


// MARK: - CollectionView

extension RMCharacterListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard  let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
      ) as? RMCharacterCollectionViewCell else {
          fatalError("Unsupported cell")
      }
    
        cell.configuer(with: cellViewModel[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter ,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? RMFooterLoadingCollectionReusableView
                 else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else{
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds  = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}


//MARK: - Scrollview

extension RMCharacterListViewViewModel: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else{
            return
        }
        let offset  = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalSVFixedHeight = scrollView.frame.height
        
        if offset >=  (totalContentHeight - totalSVFixedHeight-120){
            //Start fetching data
            fetchAdditionalCharacters(url: url)
        }
        
    }
}
