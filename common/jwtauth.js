import jwt from 'jsonwebtoken'
import crypto from 'crypto'
import config from '../config'

export default {
	TOKEN_SECRET: config.secret,
	// setToken(id) {
	// 	return jwt.sign({
	// 		id: id,
	// 		admin: false
	// 	}, this.TOKEN_SECRET, {
	// 			expiresIn: 60 * 60
	// 		})
	// },
	setToken(id, data = { admin: false }) {
		return jwt.sign(
			Object.assign({ id: id }, data),
			this.TOKEN_SECRET, {
				expiresIn: 60 * 60
			})
	},
	setMd5(value) {
		return crypto.createHash('md5').update(value).digest('hex')
	}
}