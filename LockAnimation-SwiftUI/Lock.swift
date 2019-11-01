//
//  Lock.swift
//  swiftUITry
//
//  Created by 周测 on 10/29/19.
//  Copyright © 2019 aiQG_. All rights reserved.
//

import SwiftUI

struct Lock: View, Animatable {
	
	/*@State*/ var isLocked: Bool = true
	var baseSize: CGFloat = 100
	
	init(isLocked: Bool, baseSize: CGFloat) {
		self.isLocked = isLocked
		self.baseSize = baseSize
	}
	
	var body: some View {
		VStack {
			//lock body
			RoundedRectangle(cornerRadius: baseSize * 0.2)
				.frame(width: baseSize,
					   height: baseSize - baseSize / 10)
				.overlay(
					lockAni(baseSize: baseSize, isLocked: isLocked)
						.stroke(Color.black, lineWidth: baseSize * 0.1)
			)
				.foregroundColor(.black)
			//			//Text code
			//						Button("BUTTON"){
			//							withAnimation(.easeInOut(duration: 1)){
			//								self.isLocked.toggle()
			//							}
			//						}
		}
	}
}



struct lockAni: Shape {
	var isLocked:Bool = false
	
	var baseSize:CGFloat
	var toUp:CGFloat
	var toRight:CGFloat = -0.6
	
	init(baseSize:CGFloat, isLocked:Bool) {
		self.isLocked = isLocked
		self.baseSize = baseSize
		self.toUp = isLocked ? 0 : baseSize * 0.2
		self.toRight = isLocked ? -0.6 : 0.6
	}
	
	//draw curve
	func path(in rect: CGRect) -> Path {
		var p = Path()
		p.move(to: CGPoint(x: baseSize * 0.8,
						   y: baseSize * 0.4 - toUp ))
		
		p.addLine(to: CGPoint(x: baseSize * 0.8,
							  y: -baseSize * 0.1 - toUp ))
		
		p.addCurve(
			to: CGPoint(
				x: baseSize * (0.8 + toRight),
				y: -baseSize * 0.1 - toUp),
			control1: CGPoint(
				x: baseSize * 0.8 - toRight,
				y: baseSize * (0.1 - 0.382 / 0.618) - toUp),
			control2: CGPoint(
				x: baseSize * (0.8 + toRight),
				y: baseSize * (0.1 - 0.382 / 0.618) - toUp))
		
		p.addLine(to: CGPoint(x: baseSize * (0.8 + toRight),
							  y: baseSize * 0.1 - toUp))
		
		return p
	}
	
	
	var animatableData: AnimatablePair<CGFloat, CGFloat> {
		get { return  AnimatablePair<CGFloat, CGFloat>(toUp, toRight) }
		set {
			toUp = newValue.first
			//`toRight` depend on `toUp`
			self.toRight = 1.2 * ( -sin(.pi * 1.5 * (toUp/(baseSize*0.2))) <= 0 ? 0 : -sin(.pi * 1.5 * (toUp/(baseSize*0.2))) ) - 0.6
		}
	}
}



struct Lock_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Lock(isLocked: true, baseSize: 175)
				.environment(\.colorScheme, .light)
			
			Lock(isLocked: true, baseSize: 175)
				.environment(\.colorScheme, .dark)
		}
		
	}
}
