//
//  ViewController.swift
//  Animate
//
//  Created by JHJG on 2016. 7. 18..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scaleFactor:CGFloat = 2
    var angle:Double = 180
    var boxView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //메인 뷰 객체의 서브뷰로서 boxView를 추가함.
        let frameRect = CGRectMake(20, 20, 45, 45)
        boxView = UIView(frame: frameRect)
        boxView?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(boxView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //손을 화면에서 떼는 순간 움직이게 하려고 이 메소드 사용
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            //터치가 수행된 화면상의 위치를 확인
            let location = touch.locationInView(self.view)
            
            //애미메이션 지속시간을 2초로 설정하고 커브를 ease in/ease out 으로 설정한 애니메이션 블록 클래스 메서드가 호출된다.
            UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                //크기 변화를 위한것
                let scaleTrans = CGAffineTransformMakeScale(self.scaleFactor, self.scaleFactor)
                //180도 회전을 위한것.
                let rotateTrans = CGAffineTransformMakeRotation(CGFloat(self.angle * M_PI/180))
                //위에 선언한 두가지 변환은 하나의 변환으로 합쳐지고 UIView 객체에 적용된다.
                self.boxView?.transform = CGAffineTransformConcat(scaleTrans, rotateTrans)
                
                //다음 터치에 대비하여 확대 비율과 회전각을 설정한다. 즉 처음 터치에서 180도를 회전한 다음에는 360도를 회전해야한다.
                self.angle = (self.angle == 180 ? 360 : 180)
                //마찬가지로 상자가 두배로 커진다음에는 다시 원래 크기로 애니메이션된다.
                self.scaleFactor = (self.scaleFactor == 2 ? 1 : 2)
                //뷰의 위치를 터치가 발생한 화면상의 점으로 이동시킨다.
                self.boxView?.center = location
                }, completion: nil)
        }
    }

}

