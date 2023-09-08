//
//  OnboardingVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 5.09.2023.
//

import UIKit

class OnboardingVC:UIViewController{
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardingCollectionView : UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var slides: [OnboardingSlide] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        prepareCollectionView()
        
        slides = [
            OnboardingSlide(title: "Get Instant Access to Latest News", image: "slide1"),
            OnboardingSlide(title: "Select and save favorite news.", image: "slide2"),
            OnboardingSlide(title: "Personalize Your Profile", image: "slide3" )
               ]
               
            pageControl.numberOfPages = slides.count
        
    }
    
    
    func prepareCollectionView(){
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    @IBAction func nextBtnAct(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.hasOnboarded = true
            let storyboard = UIStoryboard(name: "RegisterVC", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC {
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .coverVertical
                navigationController?.pushViewController(controller, animated: true)
                navigationController!.isNavigationBarHidden = true 
            }
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       }

       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let width = scrollView.frame.width
           currentPage = Int(scrollView.contentOffset.x / width)
       }
}
