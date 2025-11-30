# Strapi CMS on Railway

A headless CMS deployed on Railway with PostgreSQL database.

## Live Demo

🔗 **API URL**: [Your Railway URL here]
🔗 **Admin Panel**: [Your Railway URL]/admin

## Tech Stack

- **CMS**: Strapi v4
- **Database**: PostgreSQL (Railway)
- **Hosting**: Railway
- **IaC**: Terraform (for AWS reference)

## Local Development

```bash
# Install dependencies
npm install

# Start development server
npm run develop

# Access at http://localhost:1337/admin
```

## Deployment to Railway

1. Fork this repository
2. Create account at [railway.app](https://railway.app)
3. New Project → Deploy from GitHub repo
4. Add PostgreSQL database
5. Set environment variables
6. Deploy!

## Environment Variables

Set these in Railway dashboard:

| Variable              | Description                       |
| --------------------- | --------------------------------- |
| `APP_KEYS`            | Comma-separated keys for sessions |
| `ADMIN_JWT_SECRET`    | Secret for admin JWT tokens       |
| `API_TOKEN_SALT`      | Salt for API tokens               |
| `JWT_SECRET`          | Secret for API JWT tokens         |
| `TRANSFER_TOKEN_SALT` | Salt for transfer tokens          |

## Project Structure

```
├── config/          # Strapi configuration
├── src/             # Source code
│   ├── admin/       # Admin customization
│   └── api/         # Content-types & APIs
├── public/          # Static files
├── Dockerfile       # Container definition
└── package.json     # Dependencies
```

## API Endpoints

Once deployed, your API will be available at:

- `GET /api/[content-type]` - List all entries
- `GET /api/[content-type]/:id` - Get single entry
- `POST /api/[content-type]` - Create entry
- `PUT /api/[content-type]/:id` - Update entry
- `DELETE /api/[content-type]/:id` - Delete entry

## Author

[Your Name]

## License

MIT

# Run these commands to generate secrets
